# Input: A string sequence of RNA corolating to a protein
# Output: A string of the passed in protein OR an array of the passed in proteins

# Data Structure:
#   Hash - Proteins as keys and array of possible codons as values
#   Return a sring or an array depending on the method used.

# Considerations:
#   Invalid input first 3 chars don't match one of the codons raise a 
#   InvalidCodonError
#   When traversing an rna strand stop when you reach a STOP codon.

# Algorithm:
#   of_codon:
#     iterate over protein_codon_hash until codon is found then return the protein
#     If nothing is found raise InvalidCodonError



module MultiKeyHash
  def self.convert(hash)
    hash.each_with_object({}) do |(k, v), multi_hash|
      raise TypeError unless k.is_a?(Array)
      k.each do |el|
        multi_hash[el] = v
      end
    end
  end
end

class InvalidCodonError < StandardError; end

class Translation
  PROTEIN_CODON_HASH = MultiKeyHash.convert({ %w(AUG) => "Methionine",
                                              %w(UUU UUC) => "Phenylalanine",
                                              %w(UUA UUG) => "Leucine",
                                              %w(UCU UCC UCA UCG) => "Serine",
                                              %w(UAU UAC) => "Tyrosine",
                                              %w(UGU UGC) => "Cysteine",
                                              %w(UGG) => "Tryptophan",
                                              %w(UAA UAG UGA)=> "STOP" })

  def self.of_codon(codon)
    codon = PROTEIN_CODON_HASH[codon]
    codon ? codon : (raise InvalidCodonError)
  end

  def self.of_rna(rna_strand)
    rna_strand.scan(/.../).each_with_object([]) do |codon, protein|
      amino_acid = self.of_codon(codon)
      return protein if amino_acid == "STOP"
      protein << amino_acid
    end
  end  
end


