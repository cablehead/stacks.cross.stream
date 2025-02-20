Run with [http-nu](https://github.com/cablehead/http-nu):

```
http-nu :5002 (open serve.nu)
```

Then visit: http://localhost:5002

To dump pages:

```nushell
# (about section in index.html)
stacks 03CPB8QFYXKX5HKK7ENEPJDA0 --meta |
    from json |
    get clip.children |
    each {|id| stacks $id --html} |
    each {|x| $"<div>($x)</div>"} | str join "\n" | save -f ./about.html

# /releases/v0.15.6
stacks 03BDHSE4NJ8JC3NSYEC9RLWT3 --meta |
    from json |
    get clip.children |
    each {|id| stacks $id --html} |
    each {|x| $"<div>($x)</div>"} | str join "\n" | save -f ./releases/v0.15.6.html

# /how-to/window-management
nu dump/how-to-window-management.nu
```
