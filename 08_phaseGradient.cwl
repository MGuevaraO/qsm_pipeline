cwlVersion: v1.0
class: CommandLineTool

baseCommand: python3

inputs:
  outPutDir: 
    type: string
    default: "./"
    inputBinding:
      position: 5
  t2p_nii_i:
    type: Directory
    inputBinding:
      position: 4
  eresFile: 
    type: File
    inputBinding:
      position: 3
  ce_phase: 
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
  gampFile:
    type: File
    outputBinding:
      glob: "gamp.npy"
  fstOrderFit:
    type: File
    outputBinding:
      glob: 'ffoW1.nii.gz'


