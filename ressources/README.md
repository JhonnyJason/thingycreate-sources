# thingycreaty - commandline wizard to create any thingy

# Why?
I have experienced some hassles when developing on projects and their build system simultaneously. There was a convenience tool missing to support my chaotic programming style (adjust everything everywhere at once)

- Updates on the build-system, or other parts of shared code must be easily reflected onto whereever I also use them. 
- Want to shrink in granularity of what is to be it's own thingy and is shared and developed on across multiple projects.

The main problems for me were the context switches and setup-time when adding those repositores. The setup time for any new thingy and the dynamic integration of other modules must be painless and flexible.

Also there is a vision about an extensive gitOps-network for all the evolving programs in the IoT. Where this will come in handy.

When the hassles of setup, integration and deployment go to zero while we independent developers are still in full control of everything therein, then the world is awesomely perfect :D.

# What?
Thingycreate - originally thought as projectcreate - is a small project setup helper for many possible projects which inherently require a similar repository strucure and use git submodules extensivly.

It became a "thingy" instead of "project" because the concept of a project is inherently flawed by it's definition.

It is defined as a temporary endeavor with a beginning and an end. The limits set for a project are quite important for it. So no reasonable software "thingy" can really be a "project" actually.
There is just no scope for surely acceptable limitations.

Instead of looking at a single software "thingy" as a project - effectivly cripple it by putting illusionary limitations on it - we should look at the whole software evolution as an ongoing organic process, where that "thingy" is only an essentially very connected part of the whole and might evolve forever or not.

Furtherly the name "thingy" does not appear to be too cluttered by legacy associations which makes it possible to be useed as a reasonable word for the thingy concept. Which has unfolded around the development of the thingycreate as we can go further into generalization. 

Actually everything which may be referenced by a name is a thingy in that way.

It connects very well to the idea of everything is a file or everything is an URI. And even can be applied to labeled sections of code. Also any variable is a thingy in that generalized form.

# How?
Requirements
------------
* [GitHub account](https://github.com/) and/or [Gitlab account](https://gitlab.com/)
* [GitHub ssh-key access](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and/or [Gitlab ssh-key-access](https://docs.gitlab.com/ee/gitlab-basics/create-your-ssh-keys.html)
* [GitHub access token (repo scope)](https://github.com/settings/tokens) and/or [Gitlab access token (api scope)](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
* [Git installed](https://git-scm.com/)
* [Node.js installed](https://nodejs.org/)
* [Npm installed](https://www.npmjs.com/)
* [Perl installed](https://www.perl.org) (When using my toolset)

Installation
------------

Current git version
``` sh
$ npm install -g git+https://github.com/JhonnyJason/thingycreate-as-thingy-output.git
```
Npm Registry
``` sh
$ npm install -g thingycreate
```


Usage
-----

It is necessary that you have your ssh-key usable in your shell. I personally add it using the [ssh-agent](https://www.ssh.com/ssh/agent) right before I start developing anyways.



```
  Usage
      $ thingycreate <arg1> <arg2> <arg3>
    
  Options
      optional:
          arg1, --type <thingy-type>, -t <thingy-type>
              type of the thingy - one of (website, app, cli, service, machine) - not case sensitive
          arg2, --name <thingy-name>, -n <thingy-name>
              name of the thingy - should be creatable as repository and as directory in base-path
          arg3, --base-path <base-path>, -p <base-path>
              base-path of where the created thingy should have its root directory
              base-path = / and thingy-name = newThingy -> /newThingy is root directory for the thingy
          --configure, -c
              flag, if present, then the user configuration is enforced


  TO NOTE:
      The flags will overwrite the flagless argument.

  Examples
      $ thingycreate  website my-new-website /home/theuser/thingies
      ...

```

Call the script as `thingycreate` and the wizard will ask you for what he needs to know ;-)

Current Functionality
---------------------

- parameter `thingyName`: the name of the base repository
- parameter `thingyType`: type of the thingy, \"`thingyType`-recipe\" is the repository which holds the specific recipe 
- parameter `basePath`: the path where the thingy is created `basePath`/`thingyName`. The `basePath` can be relative or absolute. 
- Preemptivly checks if the necessary repositories or directories may be created in their respective locations.
- Inquires further user input then constructs that specified thingy.
- Asks if the newly created repository should be public or private.

Tips
----
If you come to experiment with this and create tons of repositories in the process you might want to take a look at [thingycontrol](https://www.npmjs.com/package/thingycontrol). A helper tool to delete those repositories again.

Here are some the recipes I use, most use my build-system.

- [void](https://gitlab.com/lenny09918050/void-recipe)
- [app](https://gitlab.com/lenny09918050/app-recipe)
- [cli](https://gitlab.com/lenny09918050/cli-recipe)
- [service](https://gitlab.com/lenny09918050/service-recipe)
- [website](https://gitlab.com/lenny09918050/website-recipe)
- [machine](https://gitlab.com/lenny09918050/machine-recipe)

Anywas everything is always just work in progress :D

---

## userConfig
When executing `thingycreate` for the first time the corresponding directories and also the `userConfig.json` do not exist.
Then `thingycreate` creates them and asks for a new user password.

```sh
  _     _       _                                                        _          
 | |_  | |__   (_)  _ __     __ _   _   _    ___   _ __    ___    __ _  | |_    ___ 
 | __| | '_ \  | | | '_ \   / _` | | | | |  / __| | '__|  / _ \  / _` | | __|  / _ \
 | |_  | | | | | | | | | | | (_| | | |_| | | (__  | |    |  __/ | (_| | | |_  |  __/
  \__| |_| |_| |_| |_| |_|  \__, |  \__, |  \___| |_|     \___|  \__,_|  \__|  \___|
                            |___/   |___/                                           
? Create new password: [input is hidden] 

```
This password is used to encrypt the sensitive parts of the user configuration. As we will store our `accessTokens` in the `userConfig.json`

It is highly recommended to use a reasonable password here.

Notice! *For the case when we donot type a new password, the we still encrypt the sensitive information by using an environment sensitive silentKey. While this silentKey is secure enough if the potential evil doesn't know your system. Any sophisticated evil who knows your system could read it, when he has read-access to your userConfig.json and also does the required research to know, how to reproduce the silent key.*

```sh
? Select a userConfigAction > 
  edit temporaryFiles path 
  ──────────────
  ──────────────
❯ new cloudService 
  ──────────────
  import thingyRecipe 
  ──────────────
(Move up and down to reveal more choices)
```
Next we have many options to configure our `thingycreate`.

If we donot have an accessible master `cloudService` or any available recipes, we cannot proceed here. Also this menu will appear every time when we execute `thingycreate` in that situation.

userConfigActions
---
---
- new `cloudService`:
    ```sh
    ? Select a cloudServiceType > (Use arrow keys)
    ❯ github 
    gitlab 
    skip 
    ```
    For the moment we may only use github and gitlab.

    For each `cloudService` Type it will ask you to provide the accessToken, the username and the hostUrl. This way you may also use your self-hosted gitlab CE.
- edit `cloudService` - it does what it sounds like
- select master `cloudService` - We may only have one master, this is the one where we create new repositories. All non-master `cloudServices` are used for reading and make up your globalScope.
- remove `cloudService` - also does what it sounds like
---
- import thingyRecipe - retrieves all available recipeThingies in your globalScope. Decide which ones you want to have available locally.
The imported recipes are available in the userConfig.json in `thingyRecipes` as ```thingyType:true``` directly accessible and editable they are stored in your `recipesPath`.

    When you donot provide a `thingyType` when calling thingycreate then you may select one of the available types. The available types are those of which their `thingyRecipe` has been imported.

    You may provide a `thingyType` which is not imported, then the recipe for that type has to be downloaded first when being used.

    You may have recipes in your `recipesPath` which are not available in your `userConfig.json`. These are not accessible and will be overwritten when you use that `thingyType`. Only officially imported recipes (available in the userConfig.json) won't be overwritten.
- remove `thingyRecipe` - kills it with fire ;)
---
- edit developerName - Maybe your name?
- edit recipes path - this is the directory where all the imported recipes are being stored.
- edit defaultThingyRoot path - When we donot provide a specific basePath this is the path where the thingy is created.
    (~/thingies)
- edit temporaryFiles path - here we download all temporary files which are then immediately deleted after usage.
    (~/.config/thingyBubble/temporaryFiles)
--- 
## thingyType -> Recipe
The recipes are the only thing which we need to understand to know how we make our own `thingyTypes` and not being confused about the creation process.

Every recipe is tied to a `thingyType` it's `thingyName`(repository name) is \"`thingyType`-recipe\". It is a requirement that we have a `recipe.json` at the root of this repository. Volunteerly we might have an `individualize.js`.


This `individualize.js` will be called as `node /absolute/path/to/individualize.js` with the current working directory set to the root of the specific newly constructed thingy.
### A Sample `recipe.json`
```json
{
    "staticBase": [
        ["merge", "createEmpty"], 
        {
            merge: ["*"]
        }
    ],
    "otherStaticBase": [
        ["merge"],
        {
            "merge": ["https://github.com/JhonnyJason/root-template"]
        }
    ],
    "module": [
        ["submodule", "directory"],
        ["create", "merge", "use"],
        {
            "create":["void", "*"],
            "merge":["my-repo", "*"],
            "use":["my-repo", "*"]
        }
    ],
    "*": true
}
```
On every Level where the array has multiple entries we have a choice for the user.
For the choices of `create`, `merge` or `use` have an object mapping further specification the possible user choices.

Here when we have the "*" as choice then the user could/should specify arbitrary input.

However this arbitrary input is checked if it is possible. Also if there is an entry in the recipe which is impossible then it is turned into a "*".

---
staticBases
---
```json
"staticBase": [
    ["merge", "createEmpty"], 
    {
        "merge": ["*"]
    }
],
"otherStaticBase": [
    ["merge"],
    {
        "merge": ["https://github.com/JhonnyJason/root-template"]
    }
]
```
Every repository which is being copied/merged into the root of the new thingy is called a staticBase.

We might also specify to not copy anything into the root of the new thingy. Then we might choose `createEmpty` on a `staticBase`.

`merge`, similar to `create` and `use` requires another option. Those possible options are mapped in the corresponding object. For `merge` we may specify a `thingyName` which we have available in our global scope or a https://... url to a public repository. This repository will then  be copied into the root of the newly created thingy being a `staticBase`.

---

thingyModules
---
```json
"module": [
    ["submodule", "directory"],
    ["create", "merge", "use"],
    {
        "create":["void", "*"],
        "merge":["my-repo", "*"],
        "use":["my-repo", "*"]
    }
]
```
While subdirectories might be part of a `staticBase` they also may be a `thingyModule`.

We generally have the choice if we want to introduce a `thingyModule` as git submodule or as a simple directory without versioning. This is the user choice of `["submodule", "direcotry"]`.

In this example there will be a directory at `basePath/thingyName/module` for that `thingyModule`.

- `merge` will copy the contents of another repository into the new module either as it's own git versioned `thingyModule` or as versionless `thingyModule`(directory)

- `create` will actually create a new thingy while the mapped option is specifying the `thingyType`. It will download the recipe if necessary and only allows input where we do the recipe for that type in our `globalScope`.

    Here we cannot provide a https://... url to a recipe. So make sure you have all the necessary repositories available in your `globalScope`.

- `use` will just add the specified repository as a subdmodule. In the case of `directory` it will clone the submodule into the `basePath` and create a symlink onto it. Here you also may use the https://... url to that repository.

---

Wildcard "*":true
---
If the ```"*":true``` is present that means we might extend the thingy arbitrarily however we desire.

```sh
? recipe * > (Use arrow keys)
❯ merge staticBase 
  add thingyModule 
  skip 
```

Then we may add new `staticBases` and new `thingyModules` until we decide to choose skip.

---

### Sample `individualze.js`
```javascript
const exec = require("child_process").exec
const pathModule = require("path")

var toolsetDir = pathModule.resolve(process.cwd(), "toolset")
var scriptPath = pathModule.resolve(toolsetDir, "prepareThingyForThingyType.pl")
exec(scriptPath, {cwd:toolsetDir}, (err, out, stderr) => console.log(out + "\nindividualized thingyType!"))
```
If you want to make more complex things in your `individualize.js` then best just call another `script` or  bundle an sophisticated `individualize.js` with all it's `node_modules`.

This script is optional and is called at the end when every part of the thingy is already in place.

---

# Further steps
This Wizard will be furtherly generalized and extended, mainly to fit my own needs.
Ideas of what could come next:

- add more extensibility for ever possible git-repository-server
- add capability to use local remotes
- derive slient Key more securely
- use relative symlink for used directories
- scan through first to collect all user decisions - then construct the thingy.
- performance enhancement when downloading git repositories


All sorts of inputs are welcome, thanks!

---

# License

## The Unlicense JhonnyJason style

- Information has no ownership.
- Information only has memory to reside in and relations to be meaningful.
- Information cannot be stolen. Only shared or destroyed.

And you wish it has been shared before it is destroyed.

The one claiming copyright or intellectual property either is really evil or probably has some insecurity issues which makes him blind to the fact that he also just connected information which was freely available to him.

The value is not in him who "created" the information the value is what is being done with the information.
So the restriction and friction of the informations' usage is exclusively reducing value overall.

The only preceived "value" gained due to restriction is actually very similar to the concept of blackmail (power gradient, control and dependency).

The real problems to solve are all in the "reward/credit" system and not the information distribution. Too much value is wasted because of not solving the right problem.

I can only contribute in that way - none of the information is "mine" everything I "learned" I actually also copied.
I only connect things to have something I feel is missing and share what I consider useful. So please use it without any second thought and please also share whatever could be useful for others. 

I also could give credits to all my sources - instead I use the freedom and moment of creativity which lives therein to declare my opinion on the situation. 

*Unity through Intelligence.*

We cannot subordinate us to the suboptimal dynamic we are spawned in, just because power is actually driving all things around us.
In the end a distributed network of intelligence where all information is transparently shared in the way that everyone has direct access to what he needs right now is more powerful than any brute power lever.

The same for our programs as for us.

It also is peaceful, helpful, friendly - decent. How it should be, because it's the most optimal solution for us human beings to learn, to connect to develop and evolve - not being excluded, let hanging and destroy oneself or others.

If we really manage to build an real AI which is far superior to us it will unify with this network of intelligence.
We never have to fear superior intelligence, because it's just the better engine connecting information to be most understandable/usable for the other part of the intelligence network.

The only thing to fear is a disconnected unit without a sufficient network of intelligence on its own, filled with fear, hate or hunger while being very powerful. That unit needs to learn and connect to develop and evolve then.

We can always just give information and hints :-) The unit needs to learn by and connect itself.

Have a nice day! :D