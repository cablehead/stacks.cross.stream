def do_404 [req: record] {
  .response {status: 404}
  $"Not Found: ($req.method) ($req.path)"
}

{|req|
  match $req {
    {method: "GET" , path: "/"} => {
      {content: "index.html" meta: (open index.json)} | to json -r | minijinja-cli -f json html/main.html -
    }

    {method: "GET"} if ($req.path | str starts-with "/releases/") => {
      let name = $req.path | path basename
      let html = "./releases/" + $name + ".html"
      if ($html | path exists) {
        {content: $html meta: (open ("./releases/" + $name + ".json"))} | to json -r | minijinja-cli -f json html/main.html -
      } else {
        do_404 $req
      }
    }

    {method: "GET"} if ($req.path | str starts-with "/css/") => {
      .static "." $req.path
    }

    {method: "GET"} if ($req.path | str starts-with "/static/") => {
      .static "." $req.path
    }

    {method: "GET" , path: "/icon.ico"} => {
      .static "." "icon.ico"
    }

    _ => (do_404 $req)
  }
}
