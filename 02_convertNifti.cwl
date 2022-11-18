cwlVersion: v1.2
class: CommandLineTool

baseCommand: python

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 6
  t2_ph_d: 
    type: Directory
    inputBinding:
      position: 5
  t2_am_d: 
    type: Directory
    inputBinding:
      position: 4
  t1_d: 
    type: Directory
    inputBinding:
      position: 3
  b1_d: 
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
  b1_n:
    type: Directory
    outputBinding:
      glob: "0--b1"
  t1_n:
    type: Directory
    outputBinding:
      glob: "07-t1"
  t2_am_n:
    type: Directory
    outputBinding:
      glob: "08-t2"
  t2_ph_n:
    type: Directory
    outputBinding:
      glob: "09-t2"

