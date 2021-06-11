using OrdinaryDiffEq
using Plots


function f(du,u,p,t)
    β,γ = p
    du[1] = -β * u[1]*u[2]
    du[2] = β * u[1]*u[2] - γ*u[2]
    du[3] = γ * u[2]
end

p = (0.4, 0.08)
u0 = [0.99,0.01,0.0]
prob = ODEProblem(f, u0,[0.0,80.0],p)

ts = solve(prob,Tsit5())

pgfplotsx()
default(dpi = 300)
default(framestyle = :box)

p = plot(ts; label = [" \$S(t) \$" " \$I(t) \$" " \$R(t) \$"], xlabel = "time, \$t\$", ylabel = "Pop. proportion", size = (250,150))
savefig(p,"figures_code/sir.pdf")