def do_404 [req: record] {
  .response {status: 404}
  $"Not Found: ($req.method) ($req.path)"
}

def do_page [prefix: string req: record] {
  let name = $req.path | path basename
  let html = $prefix + $name + ".html"
  if ($html | path exists) {
    {content: $html meta: (open ($prefix + $name + ".json"))} | to json -r | minijinja-cli -f json html/main.html -
  } else {
    do_404 $req
  }
}

{|req|
  match $req {
    {method: "GET" , path: "/"} => {
      {content: "index.html" meta: (open index.json)} | to json -r | minijinja-cli -f json html/main.html -
    }

    {method: "GET"} if ($req.path | str starts-with "/releases/") => {
      do_page "./releases/" $req
    }

    {method: "GET"} if ($req.path | str starts-with "/how-to/") => {
      do_page "./how-to/" $req
    }

    {method: "GET"} if ($req.path | str starts-with "/css/") => {
      .static (pwd) $req.path
    }

    {method: "GET"} if ($req.path | str starts-with "/static/") => {
      .static (pwd) $req.path
    }

    {method: "GET"} if ($req.path | str starts-with "/releases/") => {
      .static (pwd) $req.path
    }

    {method: "GET" , path: "/icon.ico"} => {
      .static (pwd) "icon.ico"
    }

    _ => (do_404 $req)
  }
}
