variable "target_node" {
  # Se nao for o mesmo nome nao vai funcionar 
  description = "Nome do nó Proxmox onde o container será criad"
  type        = string
}

variable "bridge" {
  description = "Interface de bridge para o LXC"
  type        = string
  default     = "vmbr0"
}

variable "ostemplate" {
  description = "Template OS para o LXC"
  type        = string
  default     = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "lxc_password" {
  description = "Senha padrão para os containers"
  type        = string
  sensitive   = true
}

variable "storage" {
  description = "Armazenamento utilizado para os discos dos containers"
  type        = string
  default     = "local"
}

variable "lxc_containers" {
  description = "Lista de containers para criar"
  type = object({
    # hostname  = string
    cores     = number
    memory    = number
    swap      = number
    disk_size = string
    ip        = string
  })
}

variable "hostname" {
  description = "Hostname dos containers"
  type        = string
  default     = "lxc-terraform"
}


variable "nameserver" {
  description = "DNS"
  type        = string
  default     = null
}

variable "tag" {
  description = "Tag para identificar os recursos"
  type        = string
  default     = null

}
variable "ssh-keys" {
  description = "Chave SSH"
  type        = list(string)
  default     = []
  sensitive   = true
}
variable "searchdomain" {
  description = "Domínio de pesquisa"
  type        = string
  default     = null

}
variable "unprivileged" {
  description = "Privilegiado"
  type        = bool
  # default     = false
}
variable "nesting" {
  description = "Permitir nesting"
  type        = bool
  # default     = false
  validation {
    condition     = (var.unprivileged == true && var.nesting == true) || (var.unprivileged == false && var.nesting == false)
    error_message = "Nesting não é permitido com privilegiado"
  }
}
variable "fuse" {
  description = "Permitir fuse"
  type        = bool
  default     = false
  # TODO verificar se é possivel fazer a validação
  # validation {
  #   condition     = var.unprivileged == false && var.fuse == true
  #   error_message = "Fuse não é permitido com privilegiado"
  # }
}
