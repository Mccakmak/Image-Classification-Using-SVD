load('data.mat');

%3a)

%Show training image 8
for i= 1:200                       
    row_vec=data.train_8(i,:);
    row_vec_reshaped=reshape(row_vec,[16,16]);
    imshow(row_vec_reshaped,[],'InitialMagnification',600);
end

%Show training image 1
for i= 1:200                        
    row_vec=data.train_1(i,:);
    row_vec_reshaped=reshape(row_vec,[16,16]);
    imshow(row_vec_reshaped,[],'InitialMagnification',600);
end

%3b)

%Our basis should be 1x256 size and element of A'*A matrix

% 3c)

% S_8 200x256, U_8 200x200, V_8 256x256, S_1 200x256, U_1 200x200, V_1
% 256x256
% S dioganal matrix and it has eigenvalues of A'*A  and V is 
% orthogonal matrix and its columns are eigenvectors of A'*A.

%3d)

[U_8,S_8,V_8]=svd(data.train_8);
[U_1,S_1,V_1]=svd(data.train_1);

%Columns of V are basis for the matrix.

for i = 1:256
    basis_8(i,:)=V_8(:,i);
end
for i = 1:256
    basis_1(i,:)=V_1(:,i);
end

%3e)
%The order of eigenvectors same with eigenvalues so most informative
%basis element is the first element of the basis.
%Obviously, from the beginning to the end, it becomes difficult to 
%understand what is in the pictures.First picture gives most information
%about our data.

for i = 1:256
    row_vec=basis_8(i,:);
    row_vec_reshaped=reshape(row_vec,[16,16]);
    imshow(row_vec_reshaped,[],'InitialMagnification',600);
end

for i = 1:256
    row_vec=basis_1(i,:);
    row_vec_reshaped=reshape(row_vec,[16,16]);
    imshow(row_vec_reshaped,[],'InitialMagnification',600);
end

%3f)

    e1=basis_8(1,:);
    e2=basis_8(2,:);
    e3=basis_8(3,:);

    f1=basis_1(1,:);
    f2=basis_1(2,:);
    f3=basis_1(3,:);

%4),5),6),7),8)

best_3_basis_8=[e1;e2;e3]';
best_3_basis_1=[f1;f2;f3]';


for i = 1:1147
    error_8(i,1)=minErrorRepresentation(best_3_basis_8,data.test(i,:)');
    error_1(i,1)=minErrorRepresentation(best_3_basis_1,data.test(i,:)');
    if(error_8(i,1)>error_1(i,1))
        labels_val(i,1)=1;
    else
        labels_val(i,1)=8;
    end
end


%9
for i = 1:1147
    if data.labels(i)==8
        reconstruction_errors_3(i,1)=error_8(i);
    else 
        reconstruction_errors_3(i,1)=error_1(i);
    end
end

%10
correctLabels=0;

for i = 1:1147
    if data.labels(i)==labels_val(i)
        correctLabels=correctLabels+1;
    end
end

accuracy_3=correctLabels/1147*100;

%11

% Most informative 2 basis
best_2_basis_8=[e1;e2]';
best_2_basis_1=[f1;f2]';

for i = 1:1147
    error_8(i,1)=minErrorRepresentation(best_2_basis_8,data.test(i,:)');
    error_1(i,1)=minErrorRepresentation(best_2_basis_1,data.test(i,:)');
    if(error_8(i,1)>error_1(i,1))
        labels_val(i,1)=1;
    else
        labels_val(i,1)=8;
    end
end


for i = 1:1147
    if data.labels(i)==8
        reconstruction_errors_2(i,1)=error_8(i);
    else 
        reconstruction_errors_2(i,1)=error_1(i);
    end
end

correctLabels=0;

for i = 1:1147
    if data.labels(i)==labels_val(i)
        correctLabels=correctLabels+1;
    end
end
 accuracy_2=correctLabels/1147*100;

% Most informative 1 basis
best_1_basis_8=[e1]';
best_1_basis_1=[f1]';


for i = 1:1147
    error_8(i,1)=minErrorRepresentation(best_1_basis_8,data.test(i,:)');
    error_1(i,1)=minErrorRepresentation(best_1_basis_1,data.test(i,:)');
    if(error_8(i,1)>error_1(i,1))
        labels_val(i,1)=1;
    else
        labels_val(i,1)=8;
    end
end

for i = 1:1147
    if data.labels(i)==8
        reconstruction_errors_1(i,1)=error_8(i);
    else 
        reconstruction_errors_1(i,1)=error_1(i);
    end
end

correctLabels=0;

for i = 1:1147
    if data.labels(i)==labels_val(i)
        correctLabels=correctLabels+1;
    end
end
 accuracy_1=correctLabels/1147*100;
 
% accuracy bar graph

accuracy_bar=[accuracy_1 accuracy_2 accuracy_3];
bar(accuracy_bar,'BaseValue',99);
hold on
bar(2,accuracy_bar(2),'g');
bar(3,accuracy_bar(3),'r');
ytickformat('%.2f%%');
set(gca,'xticklabel',{'accuracy1';'accuracy2';'accuracy3'});
hold off

% avg reconstruction bar graph
r1=mean(reconstruction_errors_1);
r2=mean(reconstruction_errors_2);
r3=mean(reconstruction_errors_3);

reconstruction_errors_mean_bar=[r1 r2 r3];
bar(reconstruction_errors_mean_bar);
hold on
bar(2,reconstruction_errors_mean_bar(2),'g');
bar(3,reconstruction_errors_mean_bar(3),'r');
set(gca,'xticklabel',{'recError1';'recError2';'recError3'});
hold off

%when the number of basis decrease to most informative basis ,the accuracy
%percentage increases and also the average reconstruction error value 
%increases.So we really could not say the relationship between accuracy
%and error in this project.

