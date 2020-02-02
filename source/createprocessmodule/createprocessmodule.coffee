createprocessmodule = {name: "createprocessmodule"}

#region modulesFromEnvironment
github = null
repositoryTree = null
thingy = null
pathHandler = null
recipe = null
cfg = null
#endregion

#region logPrintFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["createprocessmodule"]?  then console.log "[createprocessmodule]: " + arg
    return
olog = (o) -> log "\n" + ostr(o)
ostr = (o) -> JSON.stringify(o, null, 4)
print = (arg) -> console.log(arg)
#endregion
##############################################################################
createprocessmodule.initialize = () ->
    log "createprocessmodule.initialize"
    recipe = allModules.recipemodule
    github = allModules.githubhandlermodule
    repositoryTree = allModules.repositorytreehandlermodule
    thingy = allModules.thingymodule
    pathHandler = allModules.pathhandlermodule
    cfg = allModules.configmodule
    return 

#region internalFunctions
#endregion

#region exposedFunctions
createprocessmodule.execute = (thingyType, thingyName, path, configure) ->
    log "createprocessmodule.execute"
    await cfg.checkUserConfig(configure)
    await pathHandler.prepareBasePath(path)

    thingyName = await thingy.checkThingyName(thingyName)

    result = await recipe.getRecipe(thingyType)
    thingyRecipe = result.recipe
    thingyType = result.type

    print(">> Constructing thingy " + thingyName + ":")
    constructionPlan = await recipe.toConstructionPlan(thingyRecipe)
    basePath =  pathHandler.basePath

    await thingy.create(thingyName, thingyType, constructionPlan, basePath)
    return
#endregion

module.exports = createprocessmodule
