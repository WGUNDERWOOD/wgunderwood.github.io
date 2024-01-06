using GLMakie
GLMakie.activate!()

struct Object
    x::Matrix{Float64}
    y::Matrix{Float64}
    z::Matrix{Float64}
end

function rotate(object::Object, rotation::Matrix{T}) where T<:Real
    (m, n) = size(object.x)
    new_x = copy(object.x)
    new_y = copy(object.y)
    new_z = copy(object.z)

    for i in 1:m
        for j in 1:n
            new_x[i, j] = (rotation * [object.x[i, j], object.y[i, j], object.z[i, j]])[1]
            new_y[i, j] = (rotation * [object.x[i, j], object.y[i, j], object.z[i, j]])[2]
            new_z[i, j] = (rotation * [object.x[i, j], object.y[i, j], object.z[i, j]])[3]
        end
    end

    return Object(new_x, new_y, new_z)
end

function translate(object::Object, translation::Vector{T}) where T<:Real
    return Object(object.x .+ translation[1],
                  object.y .+ translation[2],
                  object.z .+ translation[3])
end

function make_torus(R, r, angle, res)
    thetas = range(0, 2 * pi, length=res)
    phis = range(0, angle, length=res)
    x = [(R + r * cos(theta)) * cos(phi) for theta in thetas, phi in phis]
    y = [(R + r * cos(theta)) * sin(phi) for theta in thetas, phi in phis]
    z = [r * sin(theta) for theta in thetas, phi in phis]
    return Object(x, y, z)
end

R = 4
r = 2
res = 10
angle = 3 / 2 * pi
t = make_torus(R, r, angle, res)

rot_cos = 2 * rand() - 1
rot_sin = sqrt(1 - rot_cos^2)
rotation = [1; 0; 0;; 0; rot_cos; -rot_sin;; 0; rot_sin; rot_cos]
translation = [-1, 1, 0]
display(rotation)
t = rotate(t, rotation)
t = translate(t, translation)

#u = LinRange(0.8, 6, 50)
#v = LinRange(0, 2π, 50)
#X1 = [u for u in u, v in v]
#Y1 = [(1/u) * cos(v) for u in u, v in v]
#Z1 = [(1/u) * sin(v) for u in u, v in v]

fig = Figure(resolution=(1200, 800))
ax = LScene(fig[1, 1], show_axis=false)
pltobj = surface!(ax, t.x, t.y, t.z;
                  #shading=true,
                  #ambient=Vec3f(0.65, 0.65, 0.65),
                  #backlight=1.0f0, color=sqrt.(X1 .^ 2 .+ Y1 .^ 2 .+ Z1 .^ 2),
                  #colormap=Reverse(:bone_1), transparency=true,
                 )
#wireframe!(ax, -X1, -Y1, Z1; transparency = true,
    #color = :gray, linewidth = 0.5)
#zoom!(ax.scene, cameracontrols(ax.scene), 0.98)
#Colorbar(fig[1, 2], pltobj, height=Relative(0.5))
#colsize!(fig.layout, 1, Aspect(1, 1.0))
fig
