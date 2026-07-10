return {
	"github/copilot.vim",
	config = function()
    -- allow copilot to find the highest node version >= 20
		local function find_highest_node(min_major)
			local paths = vim.split(os.getenv("PATH") or "", ":")
			local node_bins = {}
			local seen = {}

			-- Helper to add node if not already seen
			local function add_node(node_path)
				if
					vim.fn.filereadable(node_path) == 1
					and vim.fn.executable(node_path) == 1
					and not seen[node_path]
				then
					local handle = io.popen(node_path .. " --version 2>/dev/null")
					local version = handle and handle:read("*a") or ""
					if handle then
						handle:close()
					end
					local major = version:match("v(%d+)")
					if major and tonumber(major) and tonumber(major) >= min_major then
						table.insert(node_bins, { path = node_path, major = tonumber(major), version = version })
						seen[node_path] = true
					end
				end
			end

			-- 1. Find all 'node' executables in PATH
			for _, dir in ipairs(paths) do
				add_node(dir .. "/node")
			end

			-- 2. Find all nvm-installed node versions
			local nvm_dir = os.getenv("NVM_DIR") or (os.getenv("HOME") .. "/.nvm")
			local nvm_nodes_glob = nvm_dir .. "/versions/node/*/bin/node"
			local nvm_nodes = vim.fn.glob(nvm_nodes_glob, 0, 1)
			for _, node_path in ipairs(nvm_nodes) do
				add_node(node_path)
			end

			-- 3. Sort by major version descending
			table.sort(node_bins, function(a, b)
				return a.major > b.major
			end)

			-- 4. Log all found versions
			if #node_bins > 0 then
				-- for _, bin in ipairs(node_bins) do
				-- 	vim.notify(
				-- 		"Found node: " .. bin.path .. " (version: " .. (bin.version:gsub("\n", "")) .. ")",
				-- 		vim.log.levels.INFO
				-- 	)
				-- end
				-- vim.notify(
				-- 	"Selected node: "
				-- 		.. node_bins[1].path
				-- 		.. " (version: "
				-- 		.. (node_bins[1].version:gsub("\n", ""))
				-- 		.. ")",
				-- 	vim.log.levels.INFO
				-- )
				return node_bins[1].path
			else
				vim.notify("No suitable node version found (>= " .. min_major .. ")", vim.log.levels.WARN)
				return nil
			end
		end
    vim.g.copilot_node_command = find_highest_node(20)
	end,
}
