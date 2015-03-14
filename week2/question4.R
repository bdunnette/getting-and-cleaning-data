html <- readLines(url("http://biostat.jhsph.edu/~jleek/contact.html"))
line_numbers <- c(10, 20, 30, 100)

for(n in line_numbers){
    print(nchar(html[[n]]))    
}
