cliargumentsmodule = {name: "cliargumentsmodule"}

#region node_modules
meow = require("meow")
#endregion

#log Switch
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["cliargumentsmodule"]?  then console.log "[cliargumentsmodule]: " + arg
    return

##initialization function  -> is automatically being called!  ONLY RELY ON DOM AND VARIABLES!! NO PLUGINS NO OHTER INITIALIZATIONS!!
cliargumentsmodule.initialize = () ->
    log "cliargumentsmodule.initialize"

#region internal functions
getHelpText = ->
    log "getHelpText"
    return """
        Usage
            $ thingycreate <arg1> <arg2> <arg3>
    
        Options
            optional:
                arg1, --type <thingy-type>, -t <thingy-type>
                    type of the thingy - one of (website, app, cli, service, machine) - not case sensitive
                arg2, --name <thingy-name>, -n <thingy-name>
                    name of the thingy - should be creatable as repository and as directory in base-path
                arg3, --base-path <base-path>, -p <base-path>
                    base-path of where the created thingy should have it's root directory
                    base-path = / and thingy-name = newThingy -> /newThingy is root directory for the thingy

        TO NOTE:
            The flags will overwrite the flagless argument.

        Examples
            $ thingycreate  website my-new-website /home/theuser/thingies
            ...
    """

getOptions = ->
    log "getOptions"
    return {
        flags:
            type:
                type: "string"
                alias: "t"
            name:
                type: "string"
                alias: "n"
            basePath:
                type: "string"
                alias: "p"
            configure: 
                type: "boolean"
                alias: "c"
    }

extractMeowed = (meowed) ->
    log "extractMeowed"
    type = null
    name = null
    basePath = null
    configure = false

    if meowed.input[0]
        type = meowed.input[0]
    if meowed.input[1]
        name = meowed.input[1]
    if meowed.input[2]
        basePath = meowed.input[2]

    if meowed.flags.type
        type = meowed.flags.type
    if meowed.flags.name
        name = meowed.flags.name
    if meowed.flags.basePath
        basePath = meowed.flags.basePath
    if meowed.flags.configure then configure = true

    return {type, name, basePath, configure}

#endregion

#region exposed functions
cliargumentsmodule.extractArguments = ->
    log "cliargumentsmodule.extractArguments"
    options = getOptions()
    meowed = meow(getHelpText(), getOptions())
    extract = extractMeowed(meowed)
    return extract

#endregion exposed functions

module.exports = cliargumentsmodule