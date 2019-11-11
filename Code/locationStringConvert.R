loc2=vector(length=39)
for(i in 1:39){
  loc2[i]=toString(loc[i])
  sp=strsplit(loc2[i],' ')[[1]]
  if(length(sp)==4){
    print(loc2[i])
    loc2[i]=paste(substr(sp[2],1,9),substr(sp[4],1,10),sep=', ')
    
  }
  
}