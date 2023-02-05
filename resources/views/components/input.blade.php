
@props(['disabled' => false, 'errors', 'type' => 'text', 'label' => false])

<?php
/** @var \Illuminate\Support\ViewErrorBag $errors */
/** @var \Illuminate\View\ComponentAttributeBag  $attributes */
?>
<?php
$errorClasses = 'border-red-600 focus:border-red-600 ring-1 ring-red-600 focus:ring-red-600';
$defaultClasses = '';
$successClasses = 'border-emerald-600 focus:border-emerald-600 ring-1 ring-emerald-600 focus:ring-emerald-600';
$attributeName = preg_replace('/(\w+)\[(\w+)]/', '$1.$2', $attributes['name']);
?>
<div>
    @if ($label)
        <label>{{$label}}</label>
    @endif
    @if ($type === 'select')
        <select {{ $disabled ? 'disabled' : '' }} {!! $attributes->merge([
            'class' => 'border-gray-300 focus:border-purple-600 focus:outline-none focus:ring-purple-600 rounded-md w-full ' .
             ($errors->has($attributeName) ? $errorClasses : (old($attributeName) ? $successClasses :$defaultClasses))
        ]) !!}>
            {{ $slot }}
        </select>
    @else
        <input {{ $disabled ? 'disabled' : '' }} type="{{$type}}" {!! $attributes->merge([
            'class' => 'border-gray-300 focus:border-purple-600 focus:outline-none focus:ring-purple-600 rounded-md w-full ' .
             ($errors->has($attributeName) ? $errorClasses : (old($attributeName) ? $successClasses :$defaultClasses))
        ]) !!}>
    @endif
    @error($attributeName)
        <small class="text-red-600"> {{ $message }}</small>
    @enderror
</div>