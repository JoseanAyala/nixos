-----------------------------------------------------
-- AUTO-COMPACTING WORKSPACES
--
-- Occupied workspaces are always packed into the lowest numbers (1, 2, 3, ...):
-- closing or moving the last window out of a workspace shifts everything above
-- it down. Workspace 10 (gaming) is exempt: its windows never move and nothing
-- is ever compacted into it.

local EXCLUDED = { [10] = true }

local function compact()
	local occupied = {}
	for _, ws in ipairs(hl.get_workspaces()) do
		if ws.id > 0 and not EXCLUDED[ws.id] and ws.windows > 0 then
			occupied[#occupied + 1] = ws.id
		end
	end
	table.sort(occupied)

	local moves = {}
	local target = 0
	for _, id in ipairs(occupied) do
		target = target + 1
		while EXCLUDED[target] do
			target = target + 1
		end
		if id ~= target then
			moves[id] = target
		end
	end
	if next(moves) == nil then
		return
	end

	local active = hl.get_active_workspace()
	for _, w in ipairs(hl.get_windows()) do
		local dest = moves[w.workspace.id]
		if dest and not w.pinned then
			hl.dispatch(hl.dsp.window.move({ workspace = dest, follow = false, window = w }))
		end
	end
	if active and moves[active.id] then
		hl.dispatch(hl.dsp.focus({ workspace = moves[active.id] }))
	end
end

-- Compact on a short one-shot timer rather than inside the event handler:
-- the window that triggered the event is still mid-dispatch there, so moving
-- it again would be dropped. The `pending` flag coalesces event bursts.
local pending = false
local function schedule_compact()
	if pending then
		return
	end
	pending = true
	hl.timer(function()
		pending = false
		pcall(compact)
	end, { timeout = 30, type = "oneshot" })
end

for _, event in ipairs({
	"window.open",
	"window.close",
	"window.destroy",
	"window.move_to_workspace",
	"workspace.removed",
}) do
	hl.on(event, schedule_compact)
end

-- Settle any gaps present at startup / config reload.
schedule_compact()
