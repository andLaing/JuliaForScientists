### A Pluto.jl notebook ###
# v0.19.3

using Markdown
using InteractiveUtils

# ╔═╡ 03664f5c-d45c-11ea-21b6-91cd647a07aa
md"# Use Julia as an excel sheet calculator
"

# ╔═╡ 14158eb0-d45c-11ea-088f-330e45412320
md" We are preparing a budget for a research proposal. Let's use Julia as an excel spreadsheet"

# ╔═╡ 8b364df2-eb51-4234-ae91-82b614c3fdb1
personnelSalaries = Dict("SeniorEngineer" => 57805.0, "JuniorEngineer" => 45935.0, "PostDoc" => 45516.0)

# ╔═╡ 792b243b-b3aa-4640-a990-ac1cbc6b627b
numberOfPositions = Dict("SeniorEngineer" => 1, "PostDoc" => 1, "JuniorEngineer" => 2)

# ╔═╡ 3f29e02a-8048-48ad-a4e1-563ed1d8bf87
totalCost = sum([personnelSalaries[k] * numberOfPositions[k] for k in keys(personnelSalaries)])

# ╔═╡ f5eb8956-798c-482b-bb00-0c3a9436af04
equipment2022 = Dict("Fotodetectors"=> 40e+3, 
	"OpticalFibers"=> 30e+3,
	"Gases"=> 20e+3,
	"Servers"=> 30e+3,
	"SlowControls"=> 25e+3,
	"TpcComponents"=> 25e+3,
	"ELregion"=> 40e+3,
	"HVFT"=> 20e+3,
	"Scope"=> 15e+3,
	"ElectronicsComponents"=> 25e+3,
	"Maintenance"=> 10e+3
)

# ╔═╡ 738391dc-c770-4c4a-bd22-b5162fbd705b
equipment2023 = Dict("RadioactiveSources"=> 25e+3, 
	"DAQ"=> 60e+3,
	"Gases"=> 20e+3,
	"SupportStructure"=> 15e+3,
	"Vessel"=> 135e+3,
	"HVsources"=> 15e+3,
	"Maintenance"=> 10e+3
)

# ╔═╡ b020a945-614c-43b9-aa96-00a2b5c87857
equipmentCost2022 = sum([equipment2022[k] for k in keys(equipment2022)])

# ╔═╡ 99588cea-7be8-4b65-b589-228901ded60e
equipmentCost2023 = sum([equipment2023[k] for k in keys(equipment2023)])

# ╔═╡ 6b4ae230-1b54-46a7-a166-78c7cc766836
md"""### Personnel costs


Position | Cost per year (€) | Number of positions | Total cost (€)
:------ | :------ |:------ | :--------:
Postdoc | $(personnelSalaries["PostDoc"]) | $(numberOfPositions["PostDoc"]) | $(personnelSalaries["PostDoc"]*numberOfPositions["PostDoc"])
Senior Engineer | $(personnelSalaries["SeniorEngineer"]) | $(numberOfPositions["SeniorEngineer"]) | $(personnelSalaries["SeniorEngineer"]*numberOfPositions["SeniorEngineer"])
Junior Engineer | $(personnelSalaries["JuniorEngineer"]) | $(numberOfPositions["JuniorEngineer"]) | $(personnelSalaries["JuniorEngineer"]*numberOfPositions["JuniorEngineer"])

Total Personnel costs (€) = $(totalCost)

"""

# ╔═╡ c25bbda1-b0be-4293-8963-8f851e7b7831
md"""### Equipment 2022


Item | Cost (€) | 
:------ | :------:
Fotodetectors | $(equipment2022["Fotodetectors"]) 
Optical Fibers |$(equipment2022["OpticalFibers"]) 
Gases |$(equipment2022["Gases"]) 
Servers |$(equipment2022["Servers"]) 
Slow Controls |$(equipment2022["SlowControls"]) 
Tpc Components |$(equipment2022["TpcComponents"]) 
ELregion |$(equipment2022["ELregion"]) 
HVFT |$(equipment2022["HVFT"]) 
Scope |$(equipment2022["Scope"]) 
Electronics Components |$(equipment2022["ElectronicsComponents"]) 
Maintenance | $(equipment2022["Maintenance"])
Total equipment costs 2022 (€) = $(equipmentCost2022)
 
"""

# ╔═╡ 50bf7151-f398-4dc8-a6d9-e59abf50578a
md"""### Equipment 2023


Item | Cost (€) | 
:------ | :------:
Radioactive Sources | $(equipment2023["RadioactiveSources"]) 
DAQ |$(equipment2023["DAQ"]) 
Gases |$(equipment2023["Gases"]) 
Support Structure |$(equipment2023["SupportStructure"]) 
Vessel |$(equipment2023["Vessel"]) 
HV sources |$(equipment2023["HVsources"]) 
Maintenance |$(equipment2023["Maintenance"]) 

Total equipment costs 2023 (€) = $(equipmentCost2023)

"""

# ╔═╡ 514422c3-d23b-4bce-b1f6-a4181ecef7f7
travelESS = 24.5e+3

# ╔═╡ e77a29f9-0e94-4be7-a16b-8e052d923105
md"""### Travel


Item | Cost (€) | 
:------ | :------:
Travel to ESS | $(travelESS) 
"""

# ╔═╡ 2b449f4d-4d1c-40c2-b4ac-16df95db57ae
md"""### Total Costs 2022/2023


Year | Cost (€) | 
:------ | :------:
2022 | $(travelESS + totalCost + equipmentCost2022) 
2023 | $(travelESS + totalCost + equipmentCost2023) 
"""

# ╔═╡ b8644fb0-daa6-11ea-1e94-9bf46e7b0fad
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

# ╔═╡ 4119d19e-dcbc-11ea-3ec8-271e88e1afca
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]));

# ╔═╡ 921bba30-dcbc-11ea-13c3-87554722da8a
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]));

# ╔═╡ 5a6d1a8e-dcbc-11ea-272a-6f769c8d309c
correct(text=md"Great! You got the right answer! Let's move on to the next section.") = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]));

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─03664f5c-d45c-11ea-21b6-91cd647a07aa
# ╟─14158eb0-d45c-11ea-088f-330e45412320
# ╠═8b364df2-eb51-4234-ae91-82b614c3fdb1
# ╠═792b243b-b3aa-4640-a990-ac1cbc6b627b
# ╟─3f29e02a-8048-48ad-a4e1-563ed1d8bf87
# ╠═f5eb8956-798c-482b-bb00-0c3a9436af04
# ╠═738391dc-c770-4c4a-bd22-b5162fbd705b
# ╟─b020a945-614c-43b9-aa96-00a2b5c87857
# ╟─99588cea-7be8-4b65-b589-228901ded60e
# ╟─6b4ae230-1b54-46a7-a166-78c7cc766836
# ╟─c25bbda1-b0be-4293-8963-8f851e7b7831
# ╟─50bf7151-f398-4dc8-a6d9-e59abf50578a
# ╟─514422c3-d23b-4bce-b1f6-a4181ecef7f7
# ╟─e77a29f9-0e94-4be7-a16b-8e052d923105
# ╟─2b449f4d-4d1c-40c2-b4ac-16df95db57ae
# ╟─b8644fb0-daa6-11ea-1e94-9bf46e7b0fad
# ╟─4119d19e-dcbc-11ea-3ec8-271e88e1afca
# ╟─921bba30-dcbc-11ea-13c3-87554722da8a
# ╟─5a6d1a8e-dcbc-11ea-272a-6f769c8d309c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
