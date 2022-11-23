cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 4
  t2p_nii_i: 
    type: Directory
    inputBinding:
      position: 3
  t2a_nii_i: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/03_concatenateEchoes.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  t2a_c:
    type: File
    outputBinding:
      glob: "CE_magnitude.npy"
  t2p_c:
    type: File
    outputBinding:
      glob: "CE_phase.npy"

