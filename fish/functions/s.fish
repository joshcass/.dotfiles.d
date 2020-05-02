function s
  if test -e ember-cli-build.js
    ember s $argv
  else if test -e mix.exs
    iex -S mix phoenix.server
  else if test -e ionic.config.json
    ionic serve
  else if test -e Gemfile
      rails start $argv
  else if test -e project.clj
    lein run
  else if test -e yarn.lock
    yarn start
  else
    echo "Don't know what server to start. :("
    return 1
  end
end
