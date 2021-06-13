# ------------------------------------------------------------------------------------------------------------------------------ #
#                        Deploys Linked Services, Datasets, Pipelines And Triggers In Azure Data Factory.                        #
# ------------------------------------------------------------------------------------------------------------------------------ #

cd "D:\a\r1\a" # $(Build.ArtifactStagingDirectory) path where artifact files are stored.
$linkedServicePath = "$(ArtifactName)\linkedService"
$datasetPath = "$(ArtifactName)\dataset"
$pipelinePath = "$(ArtifactName)\pipeline"
$triggerPath = "$(ArtifactName)\trigger"

New-Item -ItemType Directory -Force -Path $linkedServicePath, $datasetPath, $pipelinePath, $triggerPath # creating directories with complete path

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name AzureRM.DataFactoryV2 -Force -AllowClobber -Scope CurrentUser
Enable-AzureRmAlias -Scope CurrentUser # resolve conflict between AzureRm module and Az module

$linkedServiceJson = (Get-ChildItem $linkedServicePath)
$datasetJson = (Get-ChildItem $datasetPath)
$pipelineJson = (Get-ChildItem $pipelinePath)
$triggerJson = (Get-ChildItem $triggerPath)

$linkedServiceMeasure = (Get-ChildItem $linkedServicePath) | Measure-Object
$datasetMeasure = (Get-ChildItem $datasetPath) | Measure-Object
$pipelineMeasure = (Get-ChildItem $pipelinePath) | Measure-Object
$triggerMeasure = (Get-ChildItem $triggerPath) | Measure-Object

if ($linkedServiceMeasure.count -ne 0) { foreach ($linkedServiceVar in $linkedServiceJson) { Set-AzureRmDataFactoryV2LinkedService -ResourceGroupName $(ResourceGroupName) -DataFactoryName $(DataFactoryName) -Name $linkedServiceVar.BaseName -Force -File $linkedServicePath\$linkedServiceVar | Format-List } }

if ($datasetMeasure.count -ne 0) { foreach ($datasetVar in $datasetJson) { Set-AzureRmDataFactoryV2Dataset -ResourceGroupName $(ResourceGroupName) -DataFactoryName $(DataFactoryName) -Name $datasetVar.BaseName -DefinitionFile $datasetPath\$datasetVar -Force } }

if ($pipelineMeasure.count -ne 0) { foreach ($pipelineVar in $pipelineJson) { Set-AzureRmDataFactoryV2Pipeline -ResourceGroupName $(ResourceGroupName) -DataFactoryName $(DataFactoryName) -Name $pipelineVar.BaseName -File $pipelinePath\$pipelineVar -Force } }

if ($triggerMeasure.count -ne 0) { foreach ($triggerVar in $triggerJson) { Set-AzureRmDataFactoryV2Trigger -ResourceGroupName $(ResourceGroupName) -DataFactoryName $(DataFactoryName) -Name $triggerVar.BaseName -DefinitionFile $triggerPath\$triggerVar -Force } }