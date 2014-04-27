dir<-"UCI HAR Dataset"

activity_labels<-read.table(sprintf("%s/activity_labels.txt",dir))
features<-read.table(sprintf("%s/features.txt",dir))


stest<-read.table(sprintf("%s/test/subject_test.txt",dir))
print(nrow(stest))
print(ncol(stest))
colnames(stest)<-"subject"

xtest<-read.table(sprintf("%s/test/X_test.txt",dir))
print(nrow(xtest))
print(ncol(xtest))
colnames(xtest)<-features[,2]

ytest<-read.table(sprintf("%s/test/Y_test.txt",dir))
print(nrow(ytest))
print(ncol(ytest))
colnames(ytest)<-"y"

test_data<-cbind(stest,xtest,ytest)

str<-read.table(sprintf("%s/train/subject_train.txt",dir))
print(nrow(str))
print(ncol(str))
colnames(str)<-"subject"

xtr<-read.table(sprintf("%s/train/X_train.txt",dir))
print(nrow(xtr))
print(ncol(xtr))
colnames(xtr)=features[,2]

ytr<-read.table(sprintf("%s/train/Y_train.txt",dir))
print(nrow(ytr))
print(ncol(ytr))
colnames(ytr)<-"y"

train_data<-cbind(str,xtr,ytr)

all_data<-rbind(test_data,train_data)

all_data<-merge(all_data,activity_labels,by.x="y",by.y="V1",all=T)

colnames(all_data)[564]<-"Activity"

col_mean_std<-grep("(mean|std)",colnames(all_data))
col_mean_std<-append(564,col_mean_std)

tidy_data<-all_data[,col_mean_std]

write.table(tidy_data,"tidy_data.txt", quote=F,col.names=T,row.names=F)

