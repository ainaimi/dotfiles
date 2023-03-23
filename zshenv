echo "Hello from .zshenv"

# exist function
function exists(){
    command -v $1 >/dev/null 2>&1
}
