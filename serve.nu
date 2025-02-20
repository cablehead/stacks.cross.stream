def do_404 [req: record] {
  .response {status: 404}
  $"Not Found: ($req.method) ($req.path)"
}

{|req|
  match $req {
    {method: "GET" , path: "/"} => {
      {content: "index.html" meta: (open index.json)} | to json -r | minijinja-cli -f json html/main.html -
    }
    _ => (do_404 $req)
  }
}
