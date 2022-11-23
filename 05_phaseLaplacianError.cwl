cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 3
  ce_mag: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/05_phaseLaplacianError.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  eres:
    type: File
    outputBinding:
      glob: "eres.npy"

