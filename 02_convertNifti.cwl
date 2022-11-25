cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  b1: 
    type: Directory
    inputBinding:
      position: 5
  t1: 
    type: Directory
    inputBinding:
      position: 4
  t2p: 
    type: Directory
    inputBinding:
      position: 3
  t2a: 
    type: Directory
    inputBinding:
      position: 2      
  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/02_convert2Nifti.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  b1_nii:
    type: Directory
    outputBinding:
      glob: "06-b1"
  t1_nii:
    type: Directory
    outputBinding:
      glob: "07-t1"
  t2a_nii:
    type: Directory
    outputBinding:
      glob: "08-t2"
  t2p_nii:
    type: Directory
    outputBinding:
      glob: "09-t2"

