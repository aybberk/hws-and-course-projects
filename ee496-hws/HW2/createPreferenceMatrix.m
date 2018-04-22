function preferenceMatrix = createPreferenceMatrix(popularity, nvars)
preferenceMatrix=zeros(nvars,20);


for i=1:nvars
    pop=popularity;
    for n=1:20
        p=cumsum(pop/sum(pop));
        a=find(rand()<p, 1, 'first');
        pop(a)=0;
        preferenceMatrix(i,a)=n;
    end
end

