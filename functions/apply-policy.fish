function apply-policy --argument-names document
    print-status iam/apply-policy "$document"
    if test -z "$document"
        print-status usage 'apply-policy <document>'
        return -1
    end

    set --local type (basename (parent $document 3 | sed 's/s$//'))
    set --local target (basename (parent $document 2))
    set --local policy (basename -s .json $document)

    switch $type
        case user group
            aws iam put-$type-policy --$type-name $target --policy-name $policy --policy-document file://$document
        case bucket
            aws s3api put-bucket-policy --bucket $target --policy file://$document
    end
end
