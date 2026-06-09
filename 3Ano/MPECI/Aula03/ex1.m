transitionMatrix = [0.7 0.2 0.3;
                    0.2 0.3 0.3;
                    0.1 0.5 0.4];

initialWeather = [1;0;0];   % Sunny on January 1

painProbability = [0.1;0.3;0.5];

weatherState = initialWeather;

expectedPainDays = 0;

for day = 1:31
    
    expectedPainDays = expectedPainDays + painProbability' * weatherState;
    
    weatherState = transitionMatrix * weatherState;

end

expectedPainDays