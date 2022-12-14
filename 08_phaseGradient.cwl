cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 5
  t2p_nii:
    type: Directory
    inputBinding:
      position: 4
  eres: 
    type: File
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
      location: ./QSM_pipeline/08_phaseGradient.py
  

outputs:
  log:
    type: File
    outputBinding:
      glob: "log.txt"
  gamp:
    type: File
    outputBinding:
      glob: "gamp.npy"
  firstOrderFit:
    type: File
    outputBinding:
      glob: 'ffoW1.nii.gz'


