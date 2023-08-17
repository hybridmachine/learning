%{
Imagine you work as a data scientist in a company that sells widgets
online. The company gives you a dataset of information from 1000
sales, which includes the time of the sale (listed in hours of the day
using a 24-hour clock, e.g., 15 = 3pm), the age of the buyer (in
years), and the number of widgets sold. The data are available at
sincxpress.com/widget_data.txt (Note: these are data I made up
for this exercise.)

1. Explain and write down a mathematical model that is appropriate
for this dataset.

2. Write the matrix equation corresponding to the model, and describe
the columns in the design matrix.

3. Compute the model coefficients using the least-squares algorithm
in MATLAB or Python. You can also divide the  coefficients
by the standard deviations of the corresponding independent
variables, which puts the various model terms in the same
scale and therefore more comparable.
%}

load widget_data.txt;

timeIdx = 1;
ageIdx = 2;
numSold = 3;
widget_data_size = size(widget_data);
numRows = widget_data_size(1);
orthogonalityCutoff = 1.0e-10;

%{
    The design matrix consists of an intercept term (Added for the y intercept), the time column and
    the age column. The observations are the number of widgets sold.

    [ones(numRows,1) widget_data(:,timeIdx) widget_data(:,ageIdx) * Beta =
    widget_data(numSold);
%}

DesignMatrix = [ones(numRows,1) widget_data(:,timeIdx) widget_data(:,ageIdx)];
ObservedData = widget_data(:,numSold);
CoefficientValues = DesignMatrix \ ObservedData;
ModelPredictions = DesignMatrix * CoefficientValues;
ModelErrors = ModelPredictions - ObservedData;
StdDevDesignMatrix = std(DesignMatrix);
NormalizedCoefficientValues = [ CoefficientValues(1); CoefficientValues(2:3) ./ StdDevDesignMatrix(2:3)' ];

IsErrorOrthogonal = (dot(ModelErrors,ModelPredictions) <= orthogonalityCutoff);

AvgVec = ones(numRows,1) * mean(ObservedData(:,1));

SumEi2 = dot(ModelErrors, ModelErrors);
SumObservedMinusAvg2 = dot((ObservedData - AvgVec),(ObservedData - AvgVec));

R2 = 1 - (SumEi2/SumObservedMinusAvg2)


