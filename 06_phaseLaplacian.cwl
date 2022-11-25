cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 3
  t2p_c: 
    type: File
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/06_phaseLaplacian.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  lap:
    type: File
    outputBinding:
      glob: "lap.npy"

