function _tide_item_env_smart
# 1. Handle Conda
if test -n "$CONDA_DEFAULT_ENV"
if test "$CONDA_DEFAULT_ENV" != "base"
# USE THE NEW IDENTITY HERE:
_tide_print_item my_yellow_env " $CONDA_DEFAULT_ENV"
end
end

# 2. Handle Pip / Venv
if test -n "$VIRTUAL_ENV"
if test "$VIRTUAL_ENV" != "$CONDA_PREFIX"
set -l venv_name (path basename "$VIRTUAL_ENV")
# AND HERE:
_tide_print_item my_yellow_env " $venv_name"
end
end
end
