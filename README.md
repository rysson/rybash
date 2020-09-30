RyBash lib
==========

Small BASH library.


Install
-------

Clone the project and install (add source to .bashrc).

```bash
mkdir -p "$HOME/.local/share"
cd "$HOME/.local/share"
https://git.sharkbits.com/misc/shell/rybash.git
./rybash/install.sh
```

Relogin, or type `. rybash/rybash.sh`.


Usage
-----

```bash
rybash-include MODULE
```

Where `MODULE` is requested module name.


Modules
-------

### arg_parse

Parse command-line arguments.

Example:
```bash
while arg_parse "$@"; do
  case "$op" in
    -f|--foo)  arg_arg foo;;
    --bar)     arg_optarg bar;;
    -b|--baz)  arg_true baz;;
    -*)        arg_error;;
  esac
done

arg_arg db && echo "File is '$db'"  || error "No database"
while arg_arg; do
  echo "Extra positional argument '$arg'"
done
```


### ask

Ask user.

Example:
```bash
ask "Your name" name "John"
# Your name [John]:
# Default: "John"

name=Stive
ask "Your name" name
# Your name [Stive]:
# Default: "Stive"

ask -bY "Install all" ok
# Install all [Y/n]:
# Default: "Y"

ask -b "Is it ok?"
# Is it ok? [y/n]
# No default, message "You should answer one of: Yes No" will be printed.

ask -c "Yes/no/kill" "Terminate process?"
# Terminate process? [Yes/no/kill]:
# Default: "yes" (lowercase)

ask -C "yes/no/Have you lost your mind" "Execute rm -rf" remove
# Execute rm -rf [yes/no/Have you lost your mind]:
# Default: "H"
```


### bashfs

Simple file-system in source bash scripts.

Example:
```bash
bashfs_read myfile.conf > content

constet="$(bashfs_read myfile.conf)"
 ```

### bool

Simple bool values.


### color

Print color sequences.

Example:
```bash
echo "This is $(c red)red$(c) text on $(c bB)blue$(c) background."

echoc "This is {red}red{-} text {b}on {bg.blue}blue{/bg} background{/b}..."
```

### error

Simple error functions.

Example:
```bash
error "Operations failed"; return   # prints message but not exits
fatal "Operations failed"           # prints and exits

error_code && echo "Error $err"
error_code $? myerr && echo "Error $myerr"
```

### sshtools

Some simple SSH wrappers.

Example:
```bash
trap mssh_exit EXIT
mssh_enter_pass myhost
mssh_call ls /
mscp myhost:/path/to/file /tmp
rsync -av --delete -e "ssh $(mssh_controlop)" /path/to/file/ ~/local/path
trap - EXIT
mssh_exit
```

### yaml

Parse simple YAML files (without references and multi-lines).

Example:
```bash
eval $(yaml_simple_parse config.yaml conf_)
: "${conf_section_sub_section_var:=my default value}"
echo $conf_section_sub_section_var
```

### toml

Parse simple TOML files (without references and multi-lines).

Example:
```bash
eval $(toml_simple_parse config.toml conf_)
: "${conf_section_sub_section_var:=my default value}"
echo $conf_section_sub_section_var
echo $conf_table_0_var $conf_table_1_var
echo "${$conf_table_var[@]}"
```

