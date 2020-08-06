# My rice

### Installing

```shell
git clone https://github.com/cleitondacosta/myrice.git ~/.myrice
cd ~/.myrice
chmod +x install.sh
./install.sh
```

### Required export in /etc/profile :warning:

If look at any script called by i3, you will see an odd function import_module.
This function is defined in the env.sh file, so how this function is sourced?

From bash manual:

```
When  bash  is started non-interactively, to run a
shell script, for example, it looks for the variable
BASH_ENV  in  the  environment,  expands its value if 
it appears there, and uses  the  expanded value as 
the name of a file to read and execute. 
Bash behaves as if the following command were executed:
       if  [ -n "$BASH_ENV" ]; then . "$BASH_ENV";
       fi
```

So you need to add this line to your /etc/profile:

```shell
export BASH_ENV="$HOME/.include/script/env.sh"
```

Yes, this will make every bash script source that file.
