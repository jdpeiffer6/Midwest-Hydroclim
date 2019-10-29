for(i in 32:dim(links)[1]){
  if(links[i,3]!='NA'){
  path=paste(toString(links[i,3]),'field_elements=73','field_elements=73',sep='&')
  a=getPercipData(path)}
}

for(i in 6){
  if(links[i,3]!='NA'){
    path=toString(links[i,3])
    a=getPercipData(path)}
}
