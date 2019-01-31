# deploy api script


api_script <- file.path('/plumber/plumber-apis', Sys.getenv('API_SCRIPT'))
port_no <- 8001

stopifnot(file.exists(api_script))

pr <- plumber::plumb(api_script)
pr$run(host='0.0.0.0', port=port_no) #view at localhost:8001 depending on run or deploy
