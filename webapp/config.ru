app = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["<h1>Hello World!</h1><br /><code>" + env.inspect + "</code>"]]
end
run app
