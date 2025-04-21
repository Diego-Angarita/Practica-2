vehicle(toyota, rav4, suv, 28000, 2022).
vehicle(toyota, corolla, sedan, 25000, 2023).
vehicle(toyota, tacoma, pickup, 32000, 2021).
vehicle(toyota, camry, sedan, 27500, 2022).
vehicle(ford, mustang, sport, 45000, 2023).
vehicle(ford, explorer, suv, 38000, 2022).
vehicle(ford, f150, pickup, 42000, 2023).
vehicle(ford, focus, sedan, 22000, 2021).
vehicle(bmw, x5, suv, 60000, 2021).
vehicle(bmw, m3, sport, 65000, 2022).
vehicle(bmw, x3, suv, 55000, 2023).
vehicle(bmw, series3, sedan, 48000, 2022).
vehicle(honda, civic, sedan, 23000, 2023).
vehicle(honda, crv  , suv, 29000, 2022).Vehicles) :-
    findall((Reference, Price), (
        vehicle(Brand, Reference, Type, Price, _),
        Price =< Budget
    ), Vehicles).

calculate_total_value([], 0).
calculate_total_value([(_, Price)|Rest], TotalValue) :-
    calculate_total_value(Rest, RestValue),
    TotalValue is RestValue + Price.

generate_report(Brand, Type, Budget, VehiclesList, TotalValue) :-
    findall((Brand, Reference, Type, Price, Year), (
        vehicle(Brand, Reference, Type, Price, Year),
        Price =< Budget
    ), VehiclesList),
    
    findall(Price, member((_, _, _, Price, _), VehiclesList), PricesList),
    sum_list(PricesList, TotalValue).

    total_price_by_type(Type, MaxBudgetPerVehicle, TotalPrice, VehicleCount) :-
    % Encontrar todos los vehículos del tipo especificado dentro del presupuesto
    findall(Price, (
        vehicle(_, _, Type, Price, _),
        Price =< MaxBudgetPerVehicle
    ), PricesList),
    
    % Calcular el precio total sumando todos los precios
    sum_list(PricesList, TotalPrice),
    
    % Contar cuántos vehículos cumplen los criterios
    length(PricesList, VehicleCount).
    
% Función auxiliar para sumar una lista de valores
sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.




meet_budget(Reference, BudgetMax) :-
    vehicle(_, Reference, _, Price, _),
    Price =< BudgetMax.

vehicles_by_brand(Brand, VehiclesList) :-
    bagof(Reference, vehicle(Brand, Reference, _, _, _), VehiclesList).

group_vehicles_by_brand(Grouped) :-
    bagof((Brand, Refs), findall(Reference, vehicle(Brand, Reference, _, _, _), Refs), Grouped).

vehicles_by_type_year(Brand, Grouped) :-
    bagof((Type, Year, Ref), vehicle(Brand, Ref, Type, _, Year), Grouped).

vehicles_by_criteria(Brand, Type, Budget, total_price_by_type(Type, MaxBudgetPerVehicle, TotalPrice, VehicleCount, VehiclesList) :-
    findall((Brand, Reference, Type, Price, Year), (
        vehicle(Brand, Reference, Type, Price, Year),
        Price =< MaxBudgetPerVehicle
    ), VehiclesList),

    findall(Price, member((_, _, _, Price, _), VehiclesList), PricesList),

    sum_list(PricesList, TotalPrice),
    
    length(VehiclesList, VehicleCount).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, Rest),
    Sum is H + Rest.

