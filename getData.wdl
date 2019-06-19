# Simple WDL

workflow TCGAflow {
    File input_data
    Int data_disk_size
    String data_mem_size
    String bioc_docker = "bioconductor/bioconductor_full:devel"

    String input_data_path = input_data
    String input_file_name = basename(input_data_path)

    call readDataTask {
        input:
        disk_size = data_disk_size,
        mem_size = data_mem_size,
        docker_image = bioc_docker,
        SampleName = input_file_name
    }
    
    output {
        File sampOut = readDataTask.sampOut
    }

}

# Task Definition

task readDataTask {

    String docker_image 
    String mem_size
    Int disk_size
    String SampleName

    runtime {
        docker: docker_image
        memory: mem_size
        cpu: "1"
        disks: "local-disk " + disk_size + " HDD"
    }

    command {
        set -e
        set -o pipefail
        pwd
    }

    output {
        File sampOut = "${SampleName}.txt"
    }

}

