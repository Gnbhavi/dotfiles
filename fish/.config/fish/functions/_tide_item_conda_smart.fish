function _tide_item_conda_smart
# Check if we are in a Conda env
if test -n "$CONDA_DEFAULT_ENV"
# If the env is NOT 'base', show it!
if test "$CONDA_DEFAULT_ENV" != "base"
_tide_print_item virtual_env " $CONDA_DEFAULT_ENV"
end
end
end
