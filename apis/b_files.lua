--[[
File mangement
]]

--[[
Usage

- write(path, data)
Writes data to file at path

- read(path)
Reads and returns data from file at path

- trimLuaExtFile(file)
Removes .lua extension of a file
Useful for loading api's

- trimLuaExtDir(dir, recursive)
Removes .lua extension of all lua files in dir

]]

function write(path, data)
	local f = fs.open(path, "w")
	f.write(data)
	f.close()
end

function read(path)
	if not fs.exists(path) then
		return nil
	end
	local f = fs.open(path, "r")
	local data = f.readAll()
	f.close()
	return data
end

function trimLuaExtFile(file)
	if (file:sub(-4)==".lua") then
		local old_file = file:sub(1, file:len()-4)
		if fs.exists(old_file) then
			fs.delete(old_file)
		end
		fs.move(file, old_file)
	end
end

function trimLuaExtDir(dir, recurse)
	for _, fileName in pairs(fs.list(dir)) do
		local file = fs.combine(dir, fileName)

		if not fs.isDir(file) then
			trimLuaExtFile(file)
		elseif recurse then
			trimLuaExtDir(file, recurse)
		end
	end
end
