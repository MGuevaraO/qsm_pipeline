cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 5
  t2a_c:
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
      location: ./QSM_pipeline/12_computeR2star.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  t2star:
    type: File
    outputBinding:
      glob: "T2star.nii.gz"
  r2star:
    type: File
    outputBinding:
      glob: "R2star.nii.gz"

