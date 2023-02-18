using PyPlot
using DifferentialEquations

function f(du, u, p, t)
    du[1] = 1
    du[2] = sqrt(v*v - 1) / u[1]
end

function pointF(k, a) # точка пересечение
    for (i,k) in enumerate(k)
        if (round(k, digits=3) == round(a, digits=3))
            global intersection = r[i]
            break
        end
    end
end

function draw() # отображение
    ax = PyPlot.axes(polar="true")
    ax.plot(t, r, linestyle="-", color="darkblue")
    ax.plot([0, angle], [0, span[2]+10], linestyle="-", color="green")
    ax.scatter(angle, intersection, color="red", zorder=5)
    println("Точка соприкосновения: (", angle, " ; ", intersection, ")")
    show()
    clf()
end

s = 12.2
v = 4.1
span = (0, 40)
angle = 6pi/4
intersection = 0

r0 = s / (v + 1) # случай 1
t0 = 0.0
ode = ODEProblem(f, [r0,t0], span)
sol = solve(ode, dtmax=0.001)
r = [u[1] for u in sol.u]
t = [u[2] for u in sol.u]
pointF(t, angle)
draw()

r0 = s / (v - 1) # случай 2
t0 = -2pi/3
ode = ODEProblem(f, [r0,t0], span)
sol = solve(ode, dtmax=0.001)
r = [u[1] for u in sol.u]
t = [u[2] for u in sol.u]
pointF(t, angle)
draw()