stacks 03CNQXHTMD078JM5Y56KOWD0V --meta |
    from json |
    get clip.children | each { |x|
        let meta = stacks $x --meta | from json
        let terse = $meta.content?.terse | default ""
        if ($terse | str starts-with "!video:") {
            return (
                {video: ($terse | | split row ":" | last)} | to json -r | minijinja-cli -f json html/video.html -
                )


        }
        stacks $x --html
    } |
		str join "\n" |
		save -f ./how-to/window-management.html
