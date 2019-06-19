# Simple WDL

workflow TCGAflow {
    Int data_disk_size
    String data_mem_size

    String bioc_docker = "bioconductor/bioconductor_full:devel"

    call readDataTask {
        input:
        disk_size = data_disk_size,
        mem_size = data_mem_size,
        docker_image = bioc_docker
    }

    task readDataTask {

        String SampleName
        String docker_image 

        runtime {
            docker: docker_image
            memory: mem_size
            cpu: "1"
            disks: "local-disk" + disk_size + " HDD"
        }

        output {
            File sampOut = "${SampleName}.txt"
        }

    }

}

