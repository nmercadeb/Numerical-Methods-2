function [XK, resd, it] = newtonn(x0, tol, itmax, fun)
    % This code is the newton method for nonlionear systems, is an iterative
    % method that allows you to approximate the solution of the system with a
    % precision tol

    % INPUT:
    % x0 = initial guess  --> column vector
    % tol = tolerance so that ||x_{k+1} - x_{k} || < tol
    % itmax = max number of iterations allowed
    % fun = @ ffunction_handler
    % OUTPUT:
    % XK = matrix where the xk form 0 to the last one are saved (the last
    % one is the solution) --> saved as columns
    % Resd = resulting residuals of iteration: ||F_k||, we want it to be 0,
    % as we are looking for f(x)=0
    % it = number of required iterations to satisfy tolerance

    xk = [x0];
    XK = [x0];
    resd = [norm(feval(fun, xk))];
    it = 1;
    tolk = 1;

    while it < itmax && tolk > tol
        J = jaco(fun, xk); % Jacobia en la posicio anterior
        fk = feval(fun, xk);
        [P, L, U] = PLU(J);
        % Si entra un vector fila es transposa. Si es columna no
        Dx = pluSolve(L, U, P, (-fk)); %Solucio de la ecuacio J*Dx = -fk
        % Intenta resoldre aquest sistema
        % Dx = J\(-fk);
        xk = xk + Dx;
        XK = [XK, xk];
        resd = [resd, norm(fk)];
        tolk = norm(XK(:, end) - XK(:, end - 1));
        it = it + 1;
    end
