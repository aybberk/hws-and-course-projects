
% creating Preference Matrix
preferenceMatrix = zeros (20,4);
for i = 1:20
    preferenceMatrix(i,:) = randperm(4);
end

% initializing Result Matrix
resultMatrix = zeros (10,4);

% creating Course Capacity Matrix
courseCapacity = [8,8,8,8];

for i=1:20
    % LABEL selectNewNumber
    
    % generate random number ( choose a course for i'th student
    X = randi(4);
    selectedCourse = preferenceMatrix(i,X);
    
    % if the selected course's capacity is full choose new course
    if courseCapacity(selectedCourse) == 0
        goto ('selectNewNumber')
        
    % if the selected course's capacity is not full, assign this student to
    % selected course and the selected course's capacity decremented by one
    else
        resultMatrix(i,selectedCourse) = 1;
        courseCapacity(selectedCourse) = courseCapacity(selectedCourse) - 1;
    end
end

disp('PREFERENCE MATRIX');
preferenceMatrix(:,:)

disp('RESULT MATRIX');
resultMatrix(:,:)

disp('COURSE CAPACITY');
courseCapacity(:)