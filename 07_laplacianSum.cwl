cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  eres:
    type: File
    inputBinding:
      position: 5
  lap:
    type: File
    inputBinding:
      position: 4
  t2p_nii: 
    type: Directory
    inputBinding:
      position: 3
  t2a_nii: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/07_laplacianSum.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  lapSum:
    type: File
    outputBinding:
      glob: "lap_sum_bias_w1.nii.gz"
  lapW:
    type: File
    outputBinding:
      glob: "lap_w.nii.gz"


