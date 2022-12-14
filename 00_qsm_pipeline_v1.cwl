#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow


inputs:
  zipFile: string
  brainTemplate: 
    type: File
    default:
      class: File
      location: ./Oasis_Template/T_template0.nii.gz
  brainProbMask: 
    type: File
    default:
      class: File
      location: ./Oasis_Template/T_template0_BrainCerebellumProbabilityMask.nii.gz

outputs:
  zipFileOut:
    type: File
    outputSource: zip_results/zipFileOut    
    
steps:    
  unzip_files:
    run: 01_unzip.cwl
    in:
      zipFileIn: zipFile
    out: [log, b1, t1, t2a, t2p, segmentation]

  convert_nifti:
    run: 02_convertNifti.cwl
    in:
      b1: unzip_files/b1
      t1: unzip_files/t1
      t2a: unzip_files/t2a
      t2p: unzip_files/t2p
    out: [log, b1_nii, t1_nii, t2a_nii, t2p_nii]
     
  concatenate_echoes:
    run: 03_concatenateEchoes.cwl
    in:
      t2a_nii: convert_nifti/t2a_nii
      t2p_nii: convert_nifti/t2p_nii
    out: [log, t2a_c, t2p_c]

  brain_extraction_reg:
    run: 04_brainExtractionAndRegistration.cwl
    in:
      brain_prob_mask: brainProbMask
      brain_template: brainTemplate
      t2m_nii: convert_nifti/t2a_nii
      t1_nii: convert_nifti/t1_nii
    out: [log, brainMaskT2] 

  phase_Laplacian_error:
    run: 05_phaseLaplacianError.cwl
    in:
      t2a_c: concatenate_echoes/t2a_c
    out: [log, eres] 

  phase_Laplacian:
    run: 06_phaseLaplacian.cwl
    in:
      t2p_c: concatenate_echoes/t2p_c
    out: [log, lap] 

  laplacian_sum:
    run: 07_laplacianSum.cwl
    in:
      t2a_nii: convert_nifti/t2a_nii
      t2p_nii: convert_nifti/t2p_nii
      lap: phase_Laplacian/lap
      eres: phase_Laplacian_error/eres
    out: [log, lapSum, lapW] 

  phase_gradient:
    run: 08_phaseGradient.cwl
    in: 
      t2p_nii: convert_nifti/t2p_nii
      eres: phase_Laplacian_error/eres
      t2p_c: concatenate_echoes/t2p_c
    out: [log, gamp, firstOrderFit] 

  brain_mask:
    run: 09_brainMask.cwl
    in:
      maskT2: brain_extraction_reg/brainMaskT2
      firstOrderFit: phase_gradient/firstOrderFit
      t2p_nii: convert_nifti/t2p_nii
    out: [log, rdfMask, qsmMask] 

  compute_RDF:
    run: 10_computeRDF.cwl
    in: 
      t2p_nii: convert_nifti/t2p_nii
      lapW: laplacian_sum/lapW
      rdfMask: brain_mask/rdfMask
      lapSum: laplacian_sum/lapSum
    out: [log, RDF] 

  compute_QSM:
    run: 11_computeQSM.cwl
    in:
      t2p: unzip_files/t2p 
      t2a: unzip_files/t2a
      RDF: compute_RDF/RDF
      maskQSM: brain_mask/qsmMask
    out: [QSM] 

  compute_R2star:
    run: 12_computeR2star.cwl
    in: 
      t2a_c: concatenate_echoes/t2a_c
      t2p_nii: convert_nifti/t2p_nii
      t2a_nii: convert_nifti/t2a_nii
    out: [log, t2star, r2star] 

  extract_ROI_values:
    run: 13_extractROIvalues.cwl
    in:
      segmentation: unzip_files/segmentation
      t2p_nii: convert_nifti/t2p_nii
      r2star: compute_R2star/r2star
      QSM: compute_QSM/QSM
    out: [log, QSM_ROIvalues, R2_ROIvalues] 

  zip_results:
    run: 14_zipResults.cwl
    in:
      r2ROIval: extract_ROI_values/R2_ROIvalues
      qsmROIval: extract_ROI_values/QSM_ROIvalues
      r2star: compute_R2star/r2star
      QSM: compute_QSM/QSM
      fileName: zipFile
    out: [zipFileOut] 
    