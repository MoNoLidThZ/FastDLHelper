--[[  ___           ___         ___           ___     
     /\__\         /\  \       /|  |         /\__\    
    /:/ _/_       /::\  \     |:|  |        /::|  |   
   /:/ /\  \     /:/\:\__\    |:|  |       /:/:|  |   
  /:/ /::\  \   /:/ /:/  /  __|:|  |      /:/|:|  |__ 
 /:/_/:/\:\__\ /:/_/:/  /  /\ |:|__|____ /:/ |:| /\__\
 \:\/:/ /:/  / \:\/:/  /   \:\/:::::/__/ \/__|:|/:/  /
  \::/ /:/  /   \::/__/     \::/~~/~         |:/:/  / 
   \/_/:/  /     \:\  \      \:\~~\          |::/  /  
     /:/  /       \:\__\      \:\__\         |:/  /   
     \/__/         \/__/       \/__/         |/__/    ]]
--$!nG1_ePlAyErZ's Fast DL Helper
--DO NOT RENAME THIS FILE OR OVERRIDES WILL NOT WORK!
local oldAddFile = overriden and oldAddFile or resource.AddFile
local oldAddSingleFile = overriden and oldAddSingleFile or resource.AddSingleFile
local ResouceTables = overriden and ResouceTables or { Files = {}, SingleFiles = {} }
local Origin = overriden and Origin or {  }
local overriden = true
function resource.AddFile(file)
	table.insert(ResouceTables.Files,file)
	local info = debug.getinfo( 1 )
	Origin[file] = string.format( "Line %d\t\"%s\"\t%s", info.currentline, info.name, info.short_src )
	oldAddFile(file)
end
function resource.AddSingleFile(file)
	table.insert(ResouceTables.SingleFiles,file)
	local info = debug.getinfo( 1 )
	Origin[file] = string.format( "Line %d\t\"%s\"\t%s", info.currentline, info.name, info.short_src )
	oldAddSingleFile(file)
end
function resource.GetTable()
	return ResouceTables
end
function resource.GetOrigin()
	return Origin
end
function resource.PostToSPKZAPI()
	local data = table.Copy(ResouceTables.Files)
	local tbl = {
		Resources = util.TableToJSON(ResouceTables),
		DownloadURL = GetConVarString("sv_downloadurl")
	}
	
	http.Post("http://api.monolidthz.com/SPKZ_GB/ResourceStats.php",tbl,function(d)
		MsgN(d)
	end)
end