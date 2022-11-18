cwlVersion: v1.2
class: CommandLineTool

baseCommand: python

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 3

  zipFileIn: 
    type: string
    inputBinding:
      position: 2

  script:
    type: File
    inputBinding:
      position: 1
    default:
      class: File
      location: ./QSM_pipeline/01_unzip.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  b1:
    type: Directory
    outputBinding:
      glob: "01-b1"
  t1:
    type: Directory
    outputBinding:
      glob: "02-t1"
  t2_am:
    type: Directory
    outputBinding:
      glob: "03-t2"
  t2_ph:
    type: Directory
    outputBinding:
      glob: "04-t2"
  segmentation:
    type: Directory
    outputBinding:
      glob: "05-segmentation"

