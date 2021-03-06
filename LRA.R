Wlocations <- which (reviews != 0, arr.ind=T)

minRank <- 0
minNorm <- 3000

ptm <- proc.time()
for (i in 90:100) {
	u <- reviewsSVDRank100$u[,1:i]
	D <- reviewsSVDRank100$d[1:i]
	v <- t(reviewsSVDRank100$v[,1:i])
	T <- u * D
	remove('u', 'D')
	LRARank <- T %*% v
	remove('T', 'v')

	sum <- 0
	for (j in 1:dim(Wlocations)[1]) {
		sum = sum + (reviews[Wlocations[j,1], Wlocations[j,2]] - LRARank[Wlocations[j,1], Wlocations[j,2]])^2
	}
	fNorm <- sqrt(sum)
	cat ("Fnorm for Rank ", i, " = ", fNorm, "\n")
	if (minNorm > fNorm) {
		minNorm <- fNorm
		minRank <- i
		minLRAmatrix <- LRARank
	}
	remove('LRARank')
}
ptm <- proc.time() - ptm
print (ptm)

save.image()
