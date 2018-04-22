function fitness = fitnessOfCourseSelection(resultMatrix, preferenceMatrix)

resultMatrix=resultMatrix{1};
if(any(sum(resultMatrix)>50))
    fitness=Inf;
else
    fitness = sum(sum(preferenceMatrix.*resultMatrix));
end